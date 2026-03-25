Class {
	#name : #ToListDataSourceActionCommand,
	#superclass : #ToListDataSourceCommand,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #accessing }
ToListDataSourceActionCommand class >> action: aValuable [

	^ self new action: aValuable
]

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

	action cull: anInfiniteElement listElement
]

{ #category : #'infinite compatibility' }
ToListDataSourceActionCommand >> dispatchToLayout: aLayout [


]

{ #category : #'infinite compatibility' }
ToListDataSourceActionCommand >> offsetPositionsIn: anInfiniteElement [

	self applyIn: anInfiniteElement
]
