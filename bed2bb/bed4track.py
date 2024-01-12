from sys import argv


out_bed = []
# parse input bed
with open(argv[1]) as f:
    for line in f:
        line = line.strip().split()
        # skip first line if it's technical
        if line[0] == 'track':
            continue
        # round score
        score = str(int(round(float(line[4]), 0)))
        # BigBed format doesn't support names longer than 254
        name = line[3]
        if len(name) > 254:
            name = 'too_long'
        # append output bed
        out_bed.append(line[:3] + [name, score] + line[5:])
# print output bed
for line in out_bed:
    print('\t'.join(line))


