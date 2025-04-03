Class {
	#name : #ToInnerBarDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToInnerBarDataSourceManager >> innerBarElement: anInnerBarElement [

	innerBarElement := anInnerBarElement
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeChanged: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeRemoved: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemsChanged [

	innerBarElement onItemsChanged
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onSelecterCommand: aCommand appliedBy: aCommandApplier [

	aCommandApplier applyCommand: aCommand
]
