Class {
	#name : #ToDataSourceUpdatedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #sending }
ToDataSourceUpdatedEvent >> sendTo: anObject [

	anObject dataSourceUpdatedEvent: self
]
