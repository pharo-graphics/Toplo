Class {
	#name : #ToBeetleTheme,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Demo-3 - BeetleTheme'
}

{ #category : #initialization }
ToBeetleTheme >> initializeStyleRules [

	super initializeStyleRules.
	self select: ToDemo6 asTypeSelector style: [

 		" installation rules "
		self
			when: ToInstallLookEvent
			write: (self property: #background)
			with: [ :e | Color lightGray ].
		self write: (self property: #geometry) with: BlCircleGeometry new.
		self
			write: (self property: #border)
			with: (BlBorder paint: Color yellow width: 4).
			
		self do: [ :e |
			e background: Color lightGray.
			e geometry: BlCircleGeometry new.
			e border: (BlBorder paint: Color yellow width: 4) ].

		" hovered rules "
		self
			when: ToHoveredLookEvent
			write: (self property: #background)
			with: Color white.
		self
			when: ToHoveredLookEvent
			write: (self property: #border)
			with: (BlBorder paint: Color blue width: 4).

		" leaved rules "
		self
			when: ToLeavedLookEvent
			write: (self property: #background)
			with: Color lightGray.
		self
			when: ToLeavedLookEvent
			write: (self property: #border)
			with: (BlBorder paint: Color yellow width: 4) ]
]
