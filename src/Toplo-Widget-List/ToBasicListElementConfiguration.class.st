Class {
	#name : #ToBasicListElementConfiguration,
	#superclass : #ToWidgetConfiguration,
	#traits : 'TObservable + TToBasicListElementConfiguration',
	#classTraits : 'TObservable classTrait + TToBasicListElementConfiguration classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBasicListElementConfiguration >> initialize [

	super initialize.
	self class initializeSlots: self.
	useCheckbox := false
]

{ #category : #hook }
ToBasicListElementConfiguration >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	self property: #useCheckbox whenChangedDo: [
			aListElement nodeManager checkableNode: useCheckbox.
			aListElement onUseCheckboxChangedWith: useCheckbox ].

	#( #uniformNodeWidth #uniformNodeHeight #autoDistribute
	   #isFlowable #isScrollable ) do: [ :flag |
			self
				property: flag
				whenChangedDo: [ aListElement requestConfiguration ] ].

	uniformNodeWidth := false.
	uniformNodeHeight := false.
	autoDistribute := false.
	isFlowable := false.
	isScrollable := true
]
