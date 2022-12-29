Class {
	#name : #ToLabeledSubmenuStrategy,
	#superclass : #ToLabeledLeftColumnStrategy,
	#instVars : [
		'rightIcon',
		'fill'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #layout }
ToLabeledSubmenuStrategy >> childrenIn: aSubmenu [

	^ (super childrenIn: aSubmenu) , { 
		  self privateJustificationFill.
		  self rightIcon }
]

{ #category : #accessing }
ToLabeledSubmenuStrategy >> privateJustificationFill [

	^ fill ifNil: [ 
		  fill := ToElement new
			          id: self privateJustificationFillId;
			          matchParent ]
]

{ #category : #accessing }
ToLabeledSubmenuStrategy >> privateJustificationFillId [

	^ #'justification'
]

{ #category : #accessing }
ToLabeledSubmenuStrategy >> rightIcon [

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
ToLabeledSubmenuStrategy >> rightIconImage [

	| ic |
	ic := BlTextElement new text: '>' asRopedText bold.
	ic constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ].
	^ ic
]
