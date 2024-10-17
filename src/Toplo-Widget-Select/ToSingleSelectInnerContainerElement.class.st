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
		'dataViewFactory',
		'dataViewBuilder',
		'fakeDataItem',
		'currentSelectedIndex'
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
ToSingleSelectInnerContainerElement >> dataViewBuilder: aValuable [
	" aValuable takes 2 args: the dataItemView and the selected dataItem "

	dataViewBuilder := aValuable.
	self refreshFromPopupListSelection
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataViewFactory [

	^ dataViewFactory
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self uninstallFakeDataView.
	self installFakeDataView
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> initialize [

	super initialize.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].

	fakeDataItem := 'X'.
	dataViewFactory := selectElement defaultDataViewFactory.
	dataViewBuilder := selectElement defaultDataViewBuilder.
		
	self installDataView.
	self installFakeDataView.
	self installTextInputElement

]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> installDataView [
		
	" add the unique view for the selected data item "
	dataView := self newDataView.
	dataView id: #dataView.
	self addChild: dataView
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> installFakeDataView [
	" add the fake node (to keep a constant minimum height )"

	fakeDataView := self newDataView.
	dataViewBuilder cull: fakeDataView cull: fakeDataItem.
	fakeDataView id: #fakeDataView.
	fakeDataView width: 0.
	self addChild: fakeDataView before: dataView
]

{ #category : #testing }
ToSingleSelectInnerContainerElement >> isMultipleSelection [ 

	^ false
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> newDataView [

	^ dataViewFactory cull: self
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> refresh [

		self
		deprecated: '#refreshFromPopupListSelection instead'
		transformWith:
		'`@rcvr refresh' -> '`@rcvr refreshFromPopupListSelection'.
	self refreshFromPopupListSelection
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> refreshFromPopupListSelection [

	| selectedIndex dataItem selectionModel originalData changedEvent |
	selectElement showHidePlaceholder.
	" No data to select from, just do nothing here "
	selectElement popupListElement dataAccessor ifEmpty: [ ^ self ].
	
	selectionModel := self popupWindowManager sieve selectionModel.
	originalData := self popupWindowManager sieve originalData.
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [ selectionModel firstIndex ].

	currentSelectedIndex := selectedIndex.
	self inputTextField text: '' asRopedText.

	dataView removeChildren.

	selectedIndex isZero
		ifTrue: [  ]
		ifFalse: [
			dataItem := originalData at: selectedIndex.
			dataViewBuilder cull: dataView cull: dataItem ].

	changedEvent := ToSingleSelectChangedEvent new.
	changedEvent selectedData: dataItem.
	changedEvent selectedIndex: selectedIndex.
	selectElement dispatchEvent: changedEvent
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> sample: aDataItem [

	self fakeDataItem: aDataItem
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
ToSingleSelectInnerContainerElement >> textInputElement: aTextInputElement [

	textInputElement := aTextInputElement 
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> uninstallFakeDataView [
		
	self removeChild: fakeDataView

]
