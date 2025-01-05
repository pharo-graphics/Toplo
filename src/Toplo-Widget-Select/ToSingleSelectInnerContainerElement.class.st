Class {
	#name : #ToSingleSelectInnerContainerElement,
	#superclass : #ToElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'fakeDataView',
		'dataView',
		'dataViewFactory',
		'dataViewBuilder',
		'fakeDataItem',
		'currentSelectedIndex',
		'filterTextField'
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
ToSingleSelectInnerContainerElement >> dataView [
	" return the element containing the selection result "

	^ dataView
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataViewBuilder: aValuable [
	" aValuable takes 2 args: the dataItemView and the selected dataItem "

	dataViewBuilder := aValuable.
	self refreshFromPopupListSelection.
	fakeDataItem ifNil: [ ^ self ].
	self reinstallFakeDataView
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
	self reinstallFakeDataView
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> filterTextField [

	^ filterTextField 
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> filterTextField: aTextField [

	filterTextField := aTextField
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
		
	self installDataView.
	self installFakeDataView.
	self installFilterTextField

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

	selectionModel := self manager sieve selectionModel.
	originalData := self manager sieve originalData.
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [ selectionModel firstIndex ].

	selectedIndex isZero ifFalse: [
		self filterTextField text: '' asRopedText ].
	currentSelectedIndex = selectedIndex ifTrue: [ ^ self ].
	currentSelectedIndex := selectedIndex.

	dataView removeChildren.

	selectedIndex isZero ifFalse: [
		dataItem := originalData at: selectedIndex.
		dataViewBuilder cull: dataView cull: dataItem ].

	changedEvent := ToSelectChangedEvent new.
	changedEvent selectedData: dataItem.
	changedEvent selectedIndex: selectedIndex.
	selectElement dispatchEvent: changedEvent
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> reinstallFakeDataView [
		
	self uninstallFakeDataView.
	self installFakeDataView 

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

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> uninstallFakeDataView [
		
	self removeChild: fakeDataView

]
