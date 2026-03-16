Class {
	#name : #ToAccordionElement,
	#superclass : #ToElement,
	#traits : 'TToCheckable + TToListItem',
	#classTraits : 'TToCheckable classTrait + TToListItem classTrait',
	#instVars : [
		'header',
		'body'
	],
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #configuration }
ToAccordionElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyConfigurationAsListItem
]

{ #category : #accessing }
ToAccordionElement >> bodyBuilder: aValuable [
	"With a body content as argument"
	
	body builder: aValuable
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> collapse [

	self isExpanded: false
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> expand [

	self isExpanded: true
]

{ #category : #accessing }
ToAccordionElement >> expandIconAtStart: aBoolean [

	header expandIconAtStart: aBoolean
]

{ #category : #accessing }
ToAccordionElement >> header [

	^ header
]

{ #category : #accessing }
ToAccordionElement >> headerBuilder: aValuable [
	"With an header as argument"
	
	header builder: aValuable
]

{ #category : #accessing }
ToAccordionElement >> headerExtraBuilder: aValuable [

	header headerExtraBuilder: aValuable
]

{ #category : #initialization }
ToAccordionElement >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.

	self initializeAsCheckable.
	self initializeHeader.
	self initializeBody.

	self
		addEventHandlerOn: ToCheckableCheckEvent
		do: [self privateExpanded: self isChecked ]
]

{ #category : #initialization }
ToAccordionElement >> initializeBody [

	body := self newBody.
	body hMatchParent.
	body vFitContent.
	self addChild: body
]

{ #category : #initialization }
ToAccordionElement >> initializeHeader [

	header := self newHeader.
	self addChild: header
]

{ #category : #testing }
ToAccordionElement >> isCollapsed [ 
	
	^ self isExpanded not
]

{ #category : #testing }
ToAccordionElement >> isCollapsed: aBoolean [

	self isExpanded: aBoolean not
]

{ #category : #testing }
ToAccordionElement >> isExpanded [

	^ self isChecked
]

{ #category : #accessing }
ToAccordionElement >> isExpanded: aBoolean [

	self checked: aBoolean
]

{ #category : #initialization }
ToAccordionElement >> newBody [

	^ ToAccordionBodyElement new
]

{ #category : #'instance creation' }
ToAccordionElement >> newHeader [ 

	^  ToAccordionHeaderElement new
]

{ #category : #skin }
ToAccordionElement >> newRawSkin [

	^ ToAccordionElementSkin new
]

{ #category : #accessing }
ToAccordionElement >> preserveBody: aBoolean [

	body preservedContent: aBoolean
]

{ #category : #testing }
ToAccordionElement >> privateExpanded: aBoolean [

	aBoolean
		ifTrue: [ body switchExpanded ]
		ifFalse: [ body switchCollapsed ]
]

{ #category : #testing }
ToAccordionElement >> privateSwitchExpanded [

	self isExpanded: self isExpanded not
]
