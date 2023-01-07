Class {
	#name : #ToPairSubmenuColumnStrategy,
	#superclass : #ToPairColumnStrategy,
	#instVars : [
		'rightIcon',
		'fill'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #layout }
ToPairSubmenuColumnStrategy >> childrenIn: aSubmenu [

	^ (super childrenIn: aSubmenu) , { 
		  self privateJustificationFill.
		  self rightIcon }
]

{ #category : #accessing }
ToPairSubmenuColumnStrategy >> privateJustificationFill [

	^ fill ifNil: [ 
		  fill := ToElement new
			          id: self privateJustificationFillId;
			          matchParent ]
]

{ #category : #accessing }
ToPairSubmenuColumnStrategy >> privateJustificationFillId [

	^ #'justification'
]

{ #category : #accessing }
ToPairSubmenuColumnStrategy >> rightIcon [

	^ rightIcon ifNil: [ 
		  rightIcon := (ToImage inner: self rightIconImage)
			               hExact: 18;
			               constraintsDo: [ :c | 
				               c linear vertical alignCenter.
				               c linear horizontal alignCenter ];
			               in: [ :im | im layout alignCenterRight ];
			               yourself ]
]

{ #category : #accessing }
ToPairSubmenuColumnStrategy >> rightIconImage [

	| ic |
	ic := BlTextElement new text: '>' asRopedText bold.
	ic constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ].
	^ ic
]
