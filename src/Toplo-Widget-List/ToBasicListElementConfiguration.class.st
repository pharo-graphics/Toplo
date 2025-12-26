Class {
	#name : #ToBasicListElementConfiguration,
	#superclass : #ToWidgetConfiguration,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#useCheckbox => ObservableSlot'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBasicListElementConfiguration >> initialize [

	super initialize.
	self class initializeSlots: self.
]

{ #category : #hook }
ToBasicListElementConfiguration >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	self property: #useCheckbox whenChangedDo: [
			aListElement nodeManager checkableNode: useCheckbox.
			aListElement onUseCheckboxChangedWith: useCheckbox ] 
]

{ #category : #'t - basic list element configuration' }
ToBasicListElementConfiguration >> useCheckbox [ 

	^ useCheckbox
]

{ #category : #'t - basic list element configuration' }
ToBasicListElementConfiguration >> useCheckbox: aBoolean [

	useCheckbox := aBoolean
]
