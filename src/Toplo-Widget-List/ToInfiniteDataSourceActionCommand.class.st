Class {
	#name : #ToInfiniteDataSourceActionCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-InnerInfiniteList'
}

{ #category : #accessing }
ToInfiniteDataSourceActionCommand >> action [

	^ action
]

{ #category : #accessing }
ToInfiniteDataSourceActionCommand >> action: aValuable [

	action := aValuable
]

{ #category : #commands }
ToInfiniteDataSourceActionCommand >> dispatchToLayout: aLayout [


]

{ #category : #commands }
ToInfiniteDataSourceActionCommand >> offsetPositionsIn: anInfiniteElement [

	action value
]
