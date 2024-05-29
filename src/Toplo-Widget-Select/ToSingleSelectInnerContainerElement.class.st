Class {
	#name : #ToSingleSelectInnerContainerElement,
	#superclass : #ToElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'textInputElement',
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

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> initialize [

	super initialize.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> isMultipleSelection [ 

	^ false
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> refresh [

	| selectedIndex dataItem selectionModel originalData |
	selectionModel := self windowManager sieve selectionModel.
	originalData := self windowManager sieve originalData.
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [
		                 selectionModel firstIndex ].
	self inputTextField text: ''.
	selectedIndex isZero ifFalse: [ dataItem := originalData at: selectedIndex ].
	dataItemViewBuilder cull: dataItemView cull: dataItem
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> selectElement: aSelectElement [

	selectElement := aSelectElement .
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

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> textInputElement [

	^ textInputElement 
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> textInputElementClass [

	^ ToSingleSelectTextInputElement 
]
