Class {
	#name : #ToSelectHeaderElement,
	#superclass : #ToElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectHeaderElement >> initialize [

	super initialize.
	self
		vFitContent;
		hMatchParent;
		id: #headerElement;
		constraintsDo: [ :c | c linear vertical alignCenter ].
		
	self addEventHandlerOn: ToPlaceholderShownEvent do: [ :event |
		event placeholder padding: (BlInsets left: 5).
		event placeholder layout alignCenterLeft ]
]
