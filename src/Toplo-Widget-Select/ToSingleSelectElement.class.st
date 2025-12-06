Class {
	#name : #ToSingleSelectElement,
	#superclass : #ToSelectElement,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #testing }
ToSingleSelectElement >> allowDeselection [

	^ self popupListElement primarySelectionMode deselectOnPressed
]

{ #category : #accessing }
ToSingleSelectElement >> allowDeselection: aBoolean [

	self popupListElement primarySelectionMode deselectOnPressed:
		aBoolean
]

{ #category : #accessing }
ToSingleSelectElement >> dataView [
	" return the element containing the selection result "

	^ self innerElement dataView
]

{ #category : #accessing }
ToSingleSelectElement >> dataViewBuilder: aValuable [
	" aValuable takes 2 args: the dataItemView and the selected dataItem "

	self innerElement dataViewBuilder: aValuable
]

{ #category : #accessing }
ToSingleSelectElement >> dataViewFactory: aValuable [

	self innerElement dataViewFactory: aValuable
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataViewBuilder [

	^ [ :theView :theDataItem |
		theView addChild: (ToLabel text: theDataItem asString) ]
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataViewFactory [

	^ [ :container | ToSingleSelectDataItemView new ]
]

{ #category : #'instance creation' }
ToSingleSelectElement >> innerElementClass [

	^ ToSingleSelectInnerContainerElement
]

{ #category : #'instance creation' }
ToSingleSelectElement >> newPopupWindowManager [

	^ ToSingleSelectPopupManager new
]

{ #category : #accessing }
ToSingleSelectElement >> selectedDataItem [

	^ self selectedDataItems ifEmpty: [ ] ifNotEmpty: [ :s | s first ]
]
