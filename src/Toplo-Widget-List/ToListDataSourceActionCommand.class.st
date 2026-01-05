Class {
	#name : #ToListDataSourceActionCommand,
	#superclass : #BlInfiniteDataSourceCommand,
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

{ #category : #commands }
ToListDataSourceActionCommand >> dispatchToLayout: aLayout [


]

{ #category : #commands }
ToListDataSourceActionCommand >> offsetPositionsIn: anInfiniteElement [

	action value
]
