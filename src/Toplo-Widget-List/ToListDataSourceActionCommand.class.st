Class {
	#name : #ToListDataSourceActionCommand,
	#superclass : #ToListDataSourceCommand,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #accessing }
ToListDataSourceActionCommand >> action [

	^ action
]

{ #category : #accessing }
ToListDataSourceActionCommand >> action: aValuable [

	action := aValuable
]

{ #category : #application }
ToListDataSourceActionCommand >> applyIn: anInfiniteElement [

	action value
]

{ #category : #'infinite compatibility' }
ToListDataSourceActionCommand >> dispatchToLayout: aLayout [


]

{ #category : #'infinite compatibility' }
ToListDataSourceActionCommand >> offsetPositionsIn: anInfiniteElement [

	self applyIn: anInfiniteElement
]
