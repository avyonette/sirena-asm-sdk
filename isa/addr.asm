#subruledef reladdr18 {
	{addr: s18} => {
		$assert(addr >= 0x00)
		reladdr = addr - $
		reladdr`18
	}

	{addr: s18} => {
		$assert(addr < 0x00)
		reladdr = addr - $ + 4
		reladdr`18
	}
}
