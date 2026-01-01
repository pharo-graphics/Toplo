Class {
	#name : #ToBasicListDataAccessor,
	#superclass : #Object,
	#traits : 'TToDataSourceWrapper',
	#classTraits : 'TToDataSourceWrapper classTrait',
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - data source wrapper - accessing' }
ToBasicListDataAccessor >> listElement [ 

	^ listElement
]

{ #category : #'t - data source wrapper - accessing' }
ToBasicListDataAccessor >> listElement: aListElement [

	listElement := aListElement 
]

{ #category : #'api - hooks' }
ToBasicListDataAccessor >> onInstalledInListElement: aListElement [

	self listElement: aListElement 
]
