Class {
	#name : #ToListDataSourceEmptinessChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'isEmpty'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #accessing }
ToListDataSourceEmptinessChangedEvent >> isEmpty [

	^ isEmpty
]

{ #category : #accessing }
ToListDataSourceEmptinessChangedEvent >> isEmpty: aBoolean [

	isEmpty := aBoolean
]

{ #category : #sending }
ToListDataSourceEmptinessChangedEvent >> sendTo: anObject [ 

	anObject listDataSourceEmptinessChangedEvent: self

	
]
