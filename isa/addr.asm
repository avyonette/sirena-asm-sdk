#subruledef reladdr18 {
	{addr: u18} => {
		reladdr = addr - $
		reladdr`18
	}
}
