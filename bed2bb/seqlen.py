from sys import argv
from Bio.SeqIO import parse

for record in parse(argv[1], 'fasta'):
    print(record.id, len(record.seq), sep='\t')

