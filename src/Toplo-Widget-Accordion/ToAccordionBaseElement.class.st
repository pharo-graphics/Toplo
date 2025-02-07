Class {
	#name : #ToAccordionBaseElement,
	#superclass : #ToAccordionAbstractElement,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #accessing }
ToAccordionBaseElement >> group: aCheckableGroup [

	header group: aCheckableGroup
]

{ #category : #initialization }
ToAccordionBaseElement >> initialize [

	super initialize.
	header addEventHandlerOn: ToCheckableCheckEvent do: [
		self privateExpanded: self isChecked ]
]

{ #category : #testing }
ToAccordionBaseElement >> isChecked [ 
	
	^ header isChecked
]

{ #category : #testing }
ToAccordionBaseElement >> isExpanded [

	^ self isChecked
]

{ #category : #accessing }
ToAccordionBaseElement >> isExpanded: aBoolean [

	header checked: aBoolean
]

{ #category : #'instance creation' }
ToAccordionBaseElement >> newHeader [ 

	^  ToAccordionCheckableHeaderElement new
]

{ #category : #skin }
ToAccordionBaseElement >> newRawSkin [

	^ ToAccordionBaseElementSkin new
]

{ #category : #'t - checkable - group' }
ToAccordionBaseElement >> privateChecked: aBoolean [

	header privateChecked: aBoolean
]

{ #category : #'t - checkable - group' }
ToAccordionBaseElement >> registerInGroup: aGroup [

	header registerInGroup: aGroup
]

{ #category : #'t - checkable - group' }
ToAccordionBaseElement >> unregisterFromGroup [

	header unregisterFromGroup
]
