Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> asPlaceholderLayer [

	^ ToPanePlaceholderLayer new
		  in: [ :placeholder | placeholder addChild: self ];
		  yourself
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> openInOBlSpaceWithoutToTheme [
	"This is a development method : use this method when your Space cannot support ToTheme management"
	| sp |
	
	self 
		deprecated:  'Use #openInSpaceWithoutToTheme instead' 
		transformWith: '`@receiver openInOBlSpaceWithoutToTheme' -> '`@receiver openInSpaceWithoutToTheme	'.
	
	sp := BlSpace new.
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
	sp := BlSpace new.
	self flag:'labordep : temporary set a nil toTheme setup, this methods should be removed when Look&Feel management will be ok'.
	sp toTheme: nil.
	sp root addChild: self.
	sp show.
	^ sp

]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme [

	self userData at: #ToTheme ifPresent: [ :th | ^ th ] ifAbsent: [
		self parentDo: [ :p | ^ p toTheme ].
		^ ToAbstractTheme current ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	self userData
		at: #ToTheme
		ifPresent: [ :currentTheme |
		currentTheme = aTheme ifTrue: [ ^ self ] ].

	self userData at: #ToTheme put: aTheme.
	self toThemeChanged
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self dispatchEvent: ToThemeChangedEvent new.
	self childrenDo: [ :c | c toThemeChanged ]
]
