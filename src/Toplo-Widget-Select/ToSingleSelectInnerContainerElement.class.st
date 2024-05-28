Class {
	#name : #ToSingleSelectInnerContainerElement,
	#superclass : #ToSelectInnerContainerElement,
	#instVars : [
		'dataItemView'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'api - hooks' }
ToSingleSelectInnerContainerElement >> onInstalledIn: aSelectElement [

	super onInstalledIn: aSelectElement.
	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self.
		
	" add the fake node (to keep a constant minimum height )"
	fakeView := dataItemViewFactory value.
	fakeView selectElement: aSelectElement.
	fakeView onInstalledIn: self.
	dataItemViewBuilder cull: fakeView cull: nil cull: fakeDataItem.
	fakeView id: #fakeNode.
	fakeView width: 0.
	self addChild: fakeView.

	" add the unique view for the selected data item "
	dataItemView := dataItemViewFactory value.
	dataItemView selectElement: aSelectElement.
	dataItemView onInstalledIn: self.
	dataItemView middleElement: textInputElement.
	self addChild: dataItemView
]

{ #category : #'api - hooks' }
ToSingleSelectInnerContainerElement >> onUninstalledIn: aSelectElement [

	dataItemView middleElement: nil.
	dataItemView onUninstalledIn: self.
	dataItemView removeFromParent.
	dataItemView := nil.
	fakeView onUninstalledIn: self.
	self removeChild: fakeView.
	fakeView := nil.
	textInputElement onInstalledIn: self.
	textInputElement := nil.
	super 	onUninstalledIn: aSelectElement
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> refresh [

	| selectedIndex dataItem |
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [
		                 selectionModel firstIndex ].
	self inputTextField text: ''.
	selectedIndex isZero ifFalse: [ dataItem := dataAccessor at: selectedIndex ].
	dataItemViewBuilder cull: dataItemView cull: dataItem
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> textInputElementClass [

	^ ToSingleSelectTextInputElement 
]
