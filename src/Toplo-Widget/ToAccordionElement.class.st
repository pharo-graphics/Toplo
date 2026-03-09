Class {
	#name : #ToAccordionElement,
	#superclass : #ToElement,
	#traits : 'TToListItem',
	#classTraits : 'TToListItem classTrait',
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

{ #category : #accessing }
ToAccordionElement >> checked: aBoolean [

	self isExpanded: aBoolean
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
ToAccordionElement >> group: aCheckableGroup [

	header group: aCheckableGroup
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
	self initializeHeader.
	self initializeBody
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
	self addChild: header.
	header addEventHandlerOn: ToCheckableCheckEvent do: [
		self privateExpanded: self isChecked ].

]

{ #category : #testing }
ToAccordionElement >> isChecked [ 
	
	^ header isChecked
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

	header checked: aBoolean
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

{ #category : #initialization }
ToAccordionElement >> notifyChanged [

	self dispatchEvent: ToAccordionCheckedEvent new
]

{ #category : #accessing }
ToAccordionElement >> preserveBody: aBoolean [

	body preservedContent: aBoolean
]

{ #category : #'t - checkable - group' }
ToAccordionElement >> privateChecked: aBoolean [

	header privateChecked: aBoolean
]

{ #category : #testing }
ToAccordionElement >> privateExpanded: aBoolean [

	aBoolean
		ifTrue: [ body switchExpanded ]
		ifFalse: [ body switchCollapsed ].
	self notifyChanged
]

{ #category : #testing }
ToAccordionElement >> privateSwitchExpanded [

	self isExpanded: self isExpanded not
]

{ #category : #'t - checkable - group' }
ToAccordionElement >> registerInGroup: aGroup [

	header registerInGroup: aGroup
]

{ #category : #'t - checkable - group' }
ToAccordionElement >> unregisterFromGroup [

	header unregisterFromGroup
]
