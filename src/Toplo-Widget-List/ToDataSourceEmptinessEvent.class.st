Class {
	#name : #ToDataSourceEmptinessEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToDataSourceEmptinessEvent >> sendTo: anObject [

	anObject dataSourceEmptinessEvent: self
]
