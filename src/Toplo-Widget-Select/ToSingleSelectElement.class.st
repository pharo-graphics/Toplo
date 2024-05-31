Class {
	#name : #ToSingleSelectElement,
	#superclass : #ToSelectElement,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSingleSelectElement >> dataItemViewBuilder: aValuable [

	self innerContainer dataItemViewBuilder: aValuable
]

{ #category : #accessing }
ToSingleSelectElement >> dataItemViewFactory: aValuable [

	self innerContainer dataItemViewFactory: aValuable
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataItemViewBuilder [

	^ [ :theView :theDataItem |
	  theView selectedDataTextField text:
		  (theDataItem ifNil: [ '' ] ifNotNil: [ :d | d asString ]) ]
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataItemViewFactory [

	^ [ ToSingleSelectDataItemView new ]
]

{ #category : #'instance creation' }
ToSingleSelectElement >> innerContainerClass [

	^ ToSingleSelectInnerContainerElement
]
