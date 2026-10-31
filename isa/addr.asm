#subruledef reladdr18 {
	{addr: s18} => {
		reladdr = addr - $ + 4
		reladdr`18
	}
}
