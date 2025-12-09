"
I am a ToTreeDataSourceWrapper 

My purpose is to wrap an Object (called dataItem) when it is added to a ToTreeDataSource.
"
Class {
	#name : #ToListDataItemWrapper,
	#superclass : #Object,
	#instVars : [
		'listElement',
		'dataItem'
	],
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #accessing }
ToListDataItemWrapper >> dataItem [ 

	^ dataItem 
]

{ #category : #accessing }
ToListDataItemWrapper >> dataItem: aDataItem [ 

	dataItem := aDataItem 
]

{ #category : #accessing }
ToListDataItemWrapper >> listElement: aListElement [

	listElement := aListElement 
]

{ #category : #'private - accessing' }
ToListDataItemWrapper >> nodeContainerAtPosition: aPositionInDataSource [

	^ listElement nodeContainersDetect: [ :container |
		  container holder dataWrapper = self ]
]

{ #category : #'private - accessing' }
ToListDataItemWrapper >> nodeContainerAtPosition: aPositionInDataSource do: aValuable [

	(self nodeContainerAtPosition: aPositionInDataSource) ifNotNil: [ :tn |
		aValuable value: tn ]
]

{ #category : #accessing }
ToListDataItemWrapper >> position [ 

	^ listElement dataSource indexOf: self 
]

{ #category : #printing }
ToListDataItemWrapper >> printOn: aStream [

	super printOn: aStream.
	aStream << '('.
	dataItem printOn: aStream.
	aStream << ')'
]

{ #category : #accessing }
ToListDataItemWrapper >> unwrappedDataItem [ 

	^ dataItem
]

{ #category : #'private - accessing' }
ToListDataItemWrapper >> updateListAtPosition: aPositionInDataSource [

	self nodeContainerAtPosition: aPositionInDataSource do: [ :container |
			container requestNewSkin.
			listElement postponeAction: [ :t |
					container holder allowSelectionNotification: true.
					container holder notifySelectedWithOption: t selectionOption ] ]
]

{ #category : #accessing }
ToListDataItemWrapper >> wrapped: aDataItem [

	self dataItem: aDataItem
]
