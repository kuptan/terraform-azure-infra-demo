import yaml
from subprocess import run, Popen, PIPE

_MODULE_PATH = 'terraform'

def get_clusters():
  with open('clusters.yaml') as file:
    clusters = yaml.load(file, Loader=yaml.FullLoader)

    return clusters['clusters']

def run_shell(command):
  # res = Popen(command, stdout=PIPE, stderr=PIPE)
  res = Popen(command)
  
  # run(command, check=True, universal_newlines=True, capture_output=True)

  res.wait()

def cleanup():
  run_shell(['rm', '-rf', '.terraform'])
  run_shell(['rm', '.terraform.lock.hcl'])

def tf_init(env, name):
  print(f'>> Initializing cluster {name}')

  args = f'-backend-config=key={env}/bootstrap.{name}.terraform.tfstate'

  process = run_shell(['terraform', 'init', args, _MODULE_PATH])

def tf_exec(op, env, name, full_name, rg_name):
  print(f'>> {op} cluster {name}')

  cmd = ['terraform', op]
  args = [
    f'-var=azure_aks_name={full_name}',
    f'-var=azure_aks_rg={rg_name}',
    f'-var=flux_target_path=clusters/{env}/{name}',
    '-auto-approve',
    _MODULE_PATH
  ]

  process = run_shell(cmd + args)
  
def process_terraform(cluster):
  name = cluster['name']
  env = cluster['env']
  full_cluster_name = f'k8s-{env}-{name}'
  full_cluster_rg_name = f'rg-{env}-cluster-{name}'
  tf_op = 'apply'

  tf_init(env, name)

  if(cluster['destroy']):
    tf_op = 'destroy'

  tf_exec(tf_op, env, name, full_cluster_name, full_cluster_rg_name)

  cleanup()

  # stdout, stderr = process.communicate()

def main():
  print("Loading clusters config")

  clusters = get_clusters()

  for c in clusters:
    if not c['enabled']:
      continue

    process_terraform(c)

main()