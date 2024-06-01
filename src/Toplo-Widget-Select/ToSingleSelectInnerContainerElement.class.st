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

{ #category : #'instance creation' }
ToSingleSelectInnerContainerElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

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
		constraintsDo: [ :c | c linear vertical alignCenter ].

	dataItemViewFactory := selectElement defaultDataItemViewFactory.
	dataItemViewBuilder := selectElement defaultDataItemViewBuilder.
		
	self initializeTextInputElement.
	self installFakeDataView.
	self installDataView.

]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> initializeTextInputElement [ 

	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> installDataView [
		
	" add the unique view for the selected data item "
	dataItemView := self newDataView.
	dataItemView middleElement: textInputElement.
	dataItemView id: #dataView.
	self addChild: dataItemView
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> installFakeDataView [
		
	" add the fake node (to keep a constant minimum height )"
	fakeView := self newDataView.
	dataItemViewBuilder cull: fakeView cull: nil cull: fakeDataItem.
	fakeView id: #fakeDataView.
	fakeView width: 0.
	self addChild: fakeView.

]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> isMultipleSelection [ 

	^ false
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> newDataView [

	^ (dataItemViewFactory cull: self)
		  container: self;
		  yourself
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

	selectElement := aSelectElement
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> textInputElement [

	^ textInputElement 
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> textInputElementClass [

	^ ToSingleSelectTextInputElement 
]
