Class {
	#name : 'ToListSelectionModelChangedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'model',
		'indexes'
	],
	#category : 'Toplo-Widget-List-Infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'Infinite'
}

{ #category : 'accessing' }
ToListSelectionModelChangedEvent >> indexes [

	^ indexes
]

{ #category : 'accessing' }
ToListSelectionModelChangedEvent >> indexes: aCollection [

	indexes := aCollection
]

{ #category : 'accessing' }
ToListSelectionModelChangedEvent >> model [

	^ model
]

{ #category : 'accessing' }
ToListSelectionModelChangedEvent >> model: aSelectionModel [

	model := aSelectionModel
]
