data = '''\
# hogehoge
foo,bar,baz,hoge
1,2,3,4

a,b,c,d
'''.strip()
{{_cursor_}}
for line in data.split('\n')[1:]:
	if line == '':
		continue
	c0, _, c2 = line.split(',')[0:3]
	print(f'{c2}\t{c0}')
