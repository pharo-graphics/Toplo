Class {
	#name : #ToItemPresetData,
	#superclass : #Object,
	#instVars : [
		'disabled',
		'unselectable',
		'hidden'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #accessing }
ToItemPresetData >> disabled [

	^ disabled ifNil: [ false ]
]

{ #category : #accessing }
ToItemPresetData >> disabled: aBoolean [

	disabled := aBoolean
]

{ #category : #accessing }
ToItemPresetData >> hidden [

	^ hidden ifNil: [ false ]
]

{ #category : #accessing }
ToItemPresetData >> hidden: aBoolean [

	hidden := aBoolean
]

{ #category : #'updating list' }
ToItemPresetData >> setupItem: anItem [ 

	disabled ifNotNil: [ anItem disabled: disabled ].
	unselectable ifNotNil: [ anItem unselectable: unselectable ].
	hidden ifNotNil: [ anItem hidden: hidden ]
]

{ #category : #accessing }
ToItemPresetData >> unselectable [

	^ unselectable ifNil: [ false ]
]

{ #category : #accessing }
ToItemPresetData >> unselectable: aBoolean [

	unselectable := aBoolean
]
