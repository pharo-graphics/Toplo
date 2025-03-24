Class {
	#name : #ToSkinDemoStyleSheetTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Demo-Skin Demo - 4'
}

{ #category : #tests }
ToSkinDemoStyleSheetTest >> testBasicRuleChangingBackgroundWhenInstalled [

	| theme elem |
	theme := ToStyleSheetTheme new.
	" default one rule "
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ] ].

	elem := ToElement new.
	elem background: Color blue.
	space toTheme: theme.
	space root addChild: elem.
	self assert: elem background paint color equals: Color blue.
	self waitTestingSpaces.
	self assert: elem background paint color equals: Color red
]

{ #category : #nil }
ToSkinDemoStyleSheetTest >> testRuleBackgroundDependsOnParentOrChildren [

	| theme elem parentElem childElem |
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
		              size: 100 asPoint;
		              position: 150 @ 50.
	childElem := ToElement new.
	parentElem addChild: childElem.
	space toTheme: theme.
	space root addChild: elem.
	space root addChild: parentElem.
	self waitTestingSpaces.
	self assert: elem background paint color equals: Color red.
	self assert: parentElem background paint color equals: Color blue.
	self assert: childElem background paint color equals: Color green.
]

{ #category : #nil }
ToSkinDemoStyleSheetTest >> testRuleBackgroundDependsOnSibling [

	| theme elem parentElem childElem container sibling1 sibling2 |
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

	space toTheme: theme.
	space root addChild: container.
	self waitTestingSpaces.
	self assert: sibling1 background paint color equals: Color blue.
	self assert: sibling2 background paint color equals: Color green.
	self assert: container background paint color equals: Color red.
]

{ #category : #tests }
ToSkinDemoStyleSheetTest >> testRuleBackgroundDependsOnSizeWithActionBlock [

	| theme elem verticalElem horizontalElem biggerElem |
	
	self skip.
	self flag: 'Skipped as it needs to be fixed for now'.
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

	elem := ToElement new
		        size: 50 asPoint;
		        position: 50 asPoint.
	verticalElem := ToElement new
		                size: 50 @ 100;
		                position: 50 @ 150.
	horizontalElem := ToElement new
		                  size: 100 @ 50;
		                  position: 150 @ 50.
	biggerElem := ToElement new
		              size: 100 asPoint;
		              position: 150 asPoint.
	space root addChild: elem.
	space root addChild: verticalElem.
	space root addChild: horizontalElem.
	space root addChild: biggerElem.
	space root whenLayoutedDoOnce: [
		space toTheme: theme.

		self waitTestingSpaces.
		self assert: elem background paint color equals: Color green.
		self
			assert: verticalElem background paint color
			equals: Color yellow.
		self
			assert: horizontalElem background paint color
			equals: Color blue.
		self assert: biggerElem background paint color equals: Color red ]
]

{ #category : #tests }
ToSkinDemoStyleSheetTest >> testRuleNestedInOtherRuleDependsOnStamp [

	| theme elem stampedElem |
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty:
		(ToFeatureProperty name: #background).
	theme styleSheet select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ].
		sr select: #stamped asStampSelector style: [ :stampSr |
			stampSr when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color green ] ]. ].

	elem := ToElement new.
	elem background: Color blue.
	stampedElem := ToElement new addStamp: #stamped.
	stampedElem background: Color blue.
	space toTheme: theme.
	space root addChild: elem.
	space root addChild: stampedElem.
	self assert: elem background paint color equals: Color blue.
	self assert: stampedElem background paint color equals: Color blue.
	self waitTestingSpaces.
	self assert: elem background paint color equals: Color red.
	self assert: stampedElem background paint color equals: Color green.
]
