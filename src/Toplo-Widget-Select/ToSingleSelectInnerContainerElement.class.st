Class {
	#name : #ToSingleSelectInnerContainerElement,
	#superclass : #ToElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'textInputElement',
		'fakeDataView',
		'dataView',
		'fakeData',
		'dataViewFactory',
		'dataViewBuilder'
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
ToSingleSelectInnerContainerElement >> dataViewBuilder [

	^ dataViewBuilder
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataViewBuilder: aValuable [

	" aValuable takes 3 args: the dataItemView, the holder in the list element and the selected dataItem "
	dataViewBuilder := aValuable.
	self refresh
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataViewFactory [

	^ dataViewFactory
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> initialize [

	super initialize.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].

	dataViewFactory := selectElement defaultDataViewFactory.
	dataViewBuilder := selectElement defaultDataViewBuilder.
		
	self initializeTextInputElement.
	self initializeFakeDataView.
	self initializeDataView.

]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> initializeDataView [
		
	" add the unique view for the selected data item "
	dataView := self newDataView.
	dataView middleElement: textInputElement.
	dataView id: #dataView.
	self addChild: dataView
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> initializeFakeDataView [
		
	" add the fake node (to keep a constant minimum height )"
	fakeDataView := self newDataView.
	dataViewBuilder cull: fakeDataView cull: nil cull: fakeData.
	fakeDataView id: #fakeDataView.
	fakeDataView width: 0.
	self addChild: fakeDataView.

]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> initializeTextInputElement [ 

	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> isMultipleSelection [ 

	^ false
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> newDataView [

	^ (dataViewFactory cull: self)
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
	dataViewBuilder cull: dataView cull: dataItem
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
