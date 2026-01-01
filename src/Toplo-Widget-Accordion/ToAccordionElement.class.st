Class {
	#name : #ToAccordionElement,
	#superclass : #ToAccordionAbstractElement,
	#traits : 'TToListItem',
	#classTraits : 'TToListItem classTrait',
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #accessing }
ToAccordionElement >> group: aCheckableGroup [

	header group: aCheckableGroup
]

{ #category : #initialization }
ToAccordionElement >> initialize [

	super initialize.
	header addEventHandlerOn: ToCheckableCheckEvent do: [
		self privateExpanded: self isChecked ]
]

{ #category : #testing }
ToAccordionElement >> isChecked [ 
	
	^ header isChecked
]

{ #category : #testing }
ToAccordionElement >> isExpanded [

	^ self isChecked
]

{ #category : #accessing }
ToAccordionElement >> isExpanded: aBoolean [

	header checked: aBoolean
]

{ #category : #'instance creation' }
ToAccordionElement >> newHeader [ 

	^  ToAccordionCheckableHeaderElement new
]

{ #category : #skin }
ToAccordionElement >> newRawSkin [

	^ ToAccordionElementSkin new
]

{ #category : #'t - checkable - group' }
ToAccordionElement >> privateChecked: aBoolean [

	header privateChecked: aBoolean
]

{ #category : #'t - checkable - group' }
ToAccordionElement >> registerInGroup: aGroup [

	header registerInGroup: aGroup
]

{ #category : #'t - checkable - group' }
ToAccordionElement >> unregisterFromGroup [

	header unregisterFromGroup
]
