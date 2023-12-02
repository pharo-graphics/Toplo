Class {
	#name : 'ToNodeHolderEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'holder'
	],
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'accessing' }
ToNodeHolderEvent >> holder [

	^ holder
]

{ #category : 'accessing' }
ToNodeHolderEvent >> holder: anHolder [

	holder := anHolder
]
