Class {
	#name : 'ToListStrongSelectionEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'indexes'
	],
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'accessing' }
ToListStrongSelectionEvent class >> indexes: aCollection [ 

	^ self new
		  indexes: aCollection;
		  yourself
]

{ #category : 'accessing' }
ToListStrongSelectionEvent >> indexes [

	^ indexes
]

{ #category : 'accessing' }
ToListStrongSelectionEvent >> indexes: aListOnInteger [

	indexes := aListOnInteger
]

{ #category : 'accessing' }
ToListStrongSelectionEvent >> sendTo: anObject [

	anObject strongSelectionEvent: self 


]
