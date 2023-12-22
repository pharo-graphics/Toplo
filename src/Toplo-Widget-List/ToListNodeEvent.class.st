Class {
	#name : 'ToListNodeEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'holder',
		'event'
	],
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'accessing' }
ToListNodeEvent >> event [

	^ event
]

{ #category : 'accessing' }
ToListNodeEvent >> event: anEvent [

	event := anEvent
]

{ #category : 'accessing' }
ToListNodeEvent >> holder [

	^ holder
]

{ #category : 'accessing' }
ToListNodeEvent >> holder: anHolder [

	holder := anHolder
]
