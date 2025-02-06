data = '''\
{
  "hoge": 1,
  "fuga": [100, 200, 300]
}
'''.strip()
{{_cursor_}}
import json
from pprint import pprint

pprint(json.loads(data)['fuga'][1])
