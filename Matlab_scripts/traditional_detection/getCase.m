function [s] = getCase(t_case,current_init, current_poly,ref_poly, ref_init)
    
    switch t_case
        case 'ref,ref'
            s = lfsr(ref_poly,ref_init);
        case 'ref,diff'
            s = lfsr(ref_poly,current_init); 
        case 'diff,diff'
            s = lfsr(current_poly, current_init);
        otherwise
            error('Why am I here!')
            
    end
