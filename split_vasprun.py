from xml.etree import ElementTree

tree = ElementTree.parse('vasprun.xml')
root = tree.getroot()
for e in root.iter():
    if 'comment' in e.attrib and 'spin' in e.attrib['comment']:
        if e.attrib['comment'].replace(' ', '') == 'spin1':
            pass
        elif e.attrib['comment'].replace(' ', '') == 'spin2':
            e.clear()
        else:
            raise UserWarning('Unrecognized spin component. Please check.')
tree.write('vasprun_up.xml')

tree = ElementTree.parse('vasprun.xml')
root = tree.getroot()
for e in root.iter():
    if 'comment' in e.attrib and 'spin' in e.attrib['comment']:
        if e.attrib['comment'].replace(' ', '') == 'spin1':
            e.clear()
        elif e.attrib['comment'].replace(' ', '') == 'spin2':
            e.attrib['comment'] = e.attrib['comment'].replace('2', '1')
        else:
            raise UserWarning('Unrecognized spin component. Please check.')
tree.write('vasprun_down.xml')


