# read_seq(f) reads a sequence f in fasta format and returns a list of the
# sequences. It does not return the IDs.

def read_seq(f):
    buf = f.readline().rstrip()
        
    dna_strings = []
        
    while buf:
        seq = ''
        if buf.startswith('>'):
            buf = f.readline().rstrip()
        while not buf.startswith('>') and buf:
            seq = seq + buf
            buf = f.readline().rstrip()
        dna_strings.append(seq)
    
    return dna_strings
    
#if __name__=='__main__':