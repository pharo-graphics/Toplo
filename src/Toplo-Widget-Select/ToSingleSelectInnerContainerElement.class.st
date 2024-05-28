Class {
	#name : #ToSingleSelectInnerContainerElement,
	#superclass : #ToSelectInnerContainerElement,
	#instVars : [
		'fakeDataItem',
		'dataItemView',
		'dataItemViewFactory',
		'dataItemViewBuilder',
		'fakeView'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataItemViewBuilder [

	^ dataItemViewBuilder
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataItemViewBuilder: aValuable [

	" aValuable takes 3 args: the dataItemView, the holder in the list element and the selected dataItem "
	dataItemViewBuilder := aValuable.
	self refresh
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataItemViewFactory [

	^ dataItemViewFactory
]

{ #category : #'api - hooks' }
ToSingleSelectInnerContainerElement >> onInstalledIn: aSelectElement [

	super onInstalledIn: aSelectElement.
	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self.

	dataItemViewFactory := aSelectElement defaultDataItemViewFactory.
	dataItemViewBuilder := aSelectElement defaultDataItemViewBuilder.
		
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

{ #category : #'accessing - selection' }
ToSingleSelectInnerContainerElement >> onSelectionChangedInSelectElement: aSelectElement [

	aSelectElement showHidePlaceholder.
	self refresh.
	aSelectElement listElement notifyPrimarySelectionDirty.
	self requestLayout
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
