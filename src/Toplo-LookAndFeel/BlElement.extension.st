Extension { #name : #BlElement }

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> openInOBlSpaceWithoutToTheme [
	"This is a development method : use this method when your Space cannot support ToTheme management"
	| sp |
	
	self 
		deprecated:  'Use #openInSpaceWithoutToTheme instead' 
		transformWith: '`@receiver openInOBlSpaceWithoutToTheme' -> '`@receiver openInSpaceWithoutToTheme	'.
	
	sp := OBlSpace new.
	self flag:'labordep : temporary set a nil toTheme setup, this methods should be removed when Look&Feel management will be ok'.
	sp toTheme: nil.
	sp root addChild: self.
	sp show.
	^ sp

]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> openInSpaceWithoutToTheme [
	"This is a development method : use this method when your Space cannot support ToTheme management"
	| sp |
	sp := OBlSpace new.
	self flag:'labordep : temporary set a nil toTheme setup, this methods should be removed when Look&Feel management will be ok'.
	sp toTheme: nil.
	sp root addChild: self.
	sp show.
	^ sp

]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme [

	^ self userData at: #ToTheme ifAbsent: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [ ToAbstractTheme current ] 
	]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	self userData at: #ToTheme ifPresent:[ :currentTheme | 
		currentTheme == aTheme ifTrue:[ ^ self ].
	] ifAbsent:[ "do nothing" ].

	self userData at: #ToTheme put: aTheme.
	self toThemeChanged
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ]
]
