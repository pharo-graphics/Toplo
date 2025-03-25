Class {
	#name : #ToSkinDemoStyleSheetTheme,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Demo-Skin Demo - 4'
}

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme class >> exampleBasicRuleChangingBackgroundWhenInstalled [

	| theme elem space |
	theme := ToStyleSheetTheme new.
	" default one rule "
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ] ].

	elem := ToElement new position: 50 asPoint.
	elem background: Color blue.
	space := BlSpace new.
	space toTheme: theme.
	space root addChild: elem.
	space show
]

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme class >> exampleRuleBackgroundDependsOnParentOrChildren [

	| theme elem space parentElem childElem |
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ].
		sr
			select:
			(ToUniversalSelector new withParent: ToElement asTypeSelector)
			style: [ :stampSr |
				stampSr
					when: ToInstallSkinEvent
					write: (theme property: #background)
					with: [ :e | Color green ] ].
		sr
			select:
			(ToUniversalSelector new withChild: ToElement asTypeSelector)
			style: [ :stampSr |
				stampSr
					when: ToInstallSkinEvent
					write: (theme property: #background)
					with: [ :e | Color blue ] ] ].

	elem := ToElement new position: 50 asPoint.
	parentElem := ToElement new
						layout: BlBasicLayout new;
		              size: 100 asPoint;
		              position: 150 @ 50.
	childElem := ToElement new position: 25 asPoint.
	parentElem addChild: childElem.
	space := BlSpace new.
	space toTheme: theme.
	space root addChild: elem.
	space root addChild: parentElem.
	space show
]

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme class >> exampleRuleBackgroundDependsOnSibling [

	| theme space container sibling1 sibling2 |
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ].
		sr
			select: (ToUniversalSelector new withSibling:
					 (ToStampSelector new addStamp: #sibling1))
			style: [ :stampSr |
				stampSr
					when: ToInstallSkinEvent
					write: (theme property: #background)
					with: [ :e | Color green ] ].
		sr
			select: (ToUniversalSelector new withSibling:
					 (ToStampSelector new addStamp: #sibling2))
			style: [ :stampSr |
				stampSr
					when: ToInstallSkinEvent
					write: (theme property: #background)
					with: [ :e | Color blue ] ] ].

	container := ToElement new
		             layout: BlBasicLayout new;
		             size: 250 @ 150;
		             position: 50 asPoint.
	sibling1 := ToElement new
		            position: 50 asPoint;
		            addStamp: #sibling1.
	sibling2 := ToElement new
		            position: 150 @ 50;
		            addStamp: #sibling2.
	container addChildren: {
			sibling1.
			sibling2 }.

	space := BlSpace new.
	space toTheme: theme.
	space root addChild: container.
	space show
]

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme class >> exampleRuleBackgroundDependsOnSizeWithActionBlock [

	| theme elem space verticalElem horizontalElem biggerElem |
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ].
		sr
			select: (ToActionSelector new action: [ :e | e width = 50 ])
				|| (ToActionSelector new action: [ :e | e height = 50 ])
			style: [ :squared |
				squared
					when: ToInstallSkinEvent
					write: (theme property: #background)
					with: [ :e | Color green ].

				squared
					select: [ :e | e width = 50 ] asActionSelector not
					style: [ :vertical |
						vertical
							when: ToInstallSkinEvent
							write: (theme property: #background)
							with: [ :e | Color blue ] ].
				squared
					select: [ :e | e height = 50 ] asActionSelector not
					style: [ :horizontal |
						horizontal
							when: ToInstallSkinEvent
							write: (theme property: #background)
							with: [ :e | Color yellow ] ] ] ].

	elem := ToElement new size: 50 asPoint; position: 50 asPoint.
	verticalElem := ToElement new
		                size: 50 @ 100;
		                position: 50 @ 150.
	horizontalElem := ToElement new
		                  size: 100 @ 50;
		                  position: 150 @ 50.
	biggerElem := ToElement new
		              size: 100 asPoint;
		              position: 150 asPoint.

	space := BlSpace new.
	space root whenLayoutedDoOnce: [ space toTheme: theme].
	space root addChild: elem.
	space root addChild: verticalElem.
	space root addChild: horizontalElem.
	space root addChild: biggerElem.
	space show
]

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme class >> exampleRuleNestedInOtherRuleDependsOnStamp [

	| theme elem stampedElem space |
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ].
		sr select: #stamped asStampSelector style: [ :stampSr |
			stampSr
				when: ToInstallSkinEvent
				write: (theme property: #background)
				with: [ :e | Color green ] ] ].

	elem := ToElement new position: 50 asPoint.
	elem background: Color blue.
	stampedElem := ToElement new
		               position: 150 @ 50;
		               addStamp: #stamped.
	stampedElem background: Color blue.

	space := BlSpace new.
	space toTheme: theme.
	space root addChild: elem.
	space root addChild: stampedElem.
	space show
]

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme >> clickedRules [ 
self
				when: ToClickedSkinEvent
				write: (self property: #background)
				with: [ :e |
					e clicked
						ifTrue: [ Color lightGreen darker ]
						ifFalse: [ Color lightRed darker ] ]
]

{ #category : #colors }
ToSkinDemoStyleSheetTheme >> constantRules [

	self write: (self property: #size) with: 100 @ 50.
	self
		write: (self property: #geometry)
		with: (BlRoundedRectangleGeometry cornerRadius: 5).
	self write: (self property: #border) with: [ :e |
		BlBorder
			paint: (e valueOfTokenNamed: #'border-paint')
			width: (e valueOfTokenNamed: #'border-radius') ]
]

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme >> hoveredRules [ 

self
				when: ToHoveredSkinEvent
				write: (self property: #background)
				with: [ :e |
					e clicked
						ifTrue: [ Color lightGreen darker ]
						ifFalse: [ Color lightRed darker ] ].
]

{ #category : #initialization }
ToSkinDemoStyleSheetTheme >> initializeStyleRules [

	super initializeStyleRules.
	self
		select: ToSkinDemo4Button asTypeSelector
		style: [
			self constantRules.
			self installRules.
			self hoveredRules.
			self leftRules.
			self clickedRules ]
]

{ #category : #colors }
ToSkinDemoStyleSheetTheme >> installRules [

	self
		when: ToInstallSkinEvent
		write: (self property: #background)
		with: [ :e |
			e clicked
				ifTrue: [ Color lightGreen ]
				ifFalse: [ Color lightRed ] ]
]

{ #category : #'as yet unclassified' }
ToSkinDemoStyleSheetTheme >> leftRules [ 
self
				when: ToLeavedSkinEvent
				write: (self property: #background)
				with: [ :e |
					e clicked
						ifTrue: [ Color lightGreen ]
						ifFalse: [ Color lightRed ] ].
]
