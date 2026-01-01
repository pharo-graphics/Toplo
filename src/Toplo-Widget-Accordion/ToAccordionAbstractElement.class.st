Class {
	#name : #ToAccordionAbstractElement,
	#superclass : #ToElement,
	#instVars : [
		'header',
		'body'
	],
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #accessing }
ToAccordionAbstractElement >> bodyBuilder: aValuable [
	"With a body content as argument"
	
	body builder: aValuable
]

{ #category : #accessing }
ToAccordionAbstractElement >> checked: aBoolean [

	self isExpanded: aBoolean
]

{ #category : #'expanding-collapsing' }
ToAccordionAbstractElement >> collapse [

	self isExpanded: false
]

{ #category : #'expanding-collapsing' }
ToAccordionAbstractElement >> expand [

	self isExpanded: true
]

{ #category : #accessing }
ToAccordionAbstractElement >> expandIconAtStart: aBoolean [

	header expandIconAtStart: aBoolean
]

{ #category : #accessing }
ToAccordionAbstractElement >> header [

	^ header
]

{ #category : #accessing }
ToAccordionAbstractElement >> headerBuilder: aValuable [
	"With an header as argument"
	
	header builder: aValuable
]

{ #category : #accessing }
ToAccordionAbstractElement >> headerExtraBuilder: aValuable [

	header headerExtraBuilder: aValuable
]

{ #category : #initialization }
ToAccordionAbstractElement >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.
	self initializeHeader.
	self initializeBody
]

{ #category : #initialization }
ToAccordionAbstractElement >> initializeBody [

	body := self newBody.
	body hMatchParent.
	body vFitContent.
	self addChild: body
]

{ #category : #'instance creation' }
ToAccordionAbstractElement >> initializeHeader [

	header := self newHeader.
	self addChild: header
]

{ #category : #testing }
ToAccordionAbstractElement >> isCollapsed [ 
	
	^ self isExpanded not
]

{ #category : #testing }
ToAccordionAbstractElement >> isCollapsed: aBoolean [

	self isExpanded: aBoolean not
]

{ #category : #testing }
ToAccordionAbstractElement >> isExpanded [
	
	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAccordionAbstractElement >> isExpanded: aBoolean [
	
	self subclassResponsibility 
]

{ #category : #initialization }
ToAccordionAbstractElement >> newBody [

	^ ToAccordionBodyElement new
]

{ #category : #'instance creation' }
ToAccordionAbstractElement >> newHeader [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAccordionAbstractElement >> notifyChanged [

	self dispatchEvent: ToAccordionCheckedEvent new
]

{ #category : #accessing }
ToAccordionAbstractElement >> preserveBody: aBoolean [

	body preservedContent: aBoolean
]

{ #category : #testing }
ToAccordionAbstractElement >> privateExpanded: aBoolean [

	aBoolean
		ifTrue: [ body switchExpanded ]
		ifFalse: [ body switchCollapsed ].
	self notifyChanged
]

{ #category : #testing }
ToAccordionAbstractElement >> privateSwitchExpanded [

	self isExpanded: self isExpanded not
]
