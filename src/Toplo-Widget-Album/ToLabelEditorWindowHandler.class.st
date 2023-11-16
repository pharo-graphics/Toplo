Class {
	#name : 'ToLabelEditorWindowHandler',
	#superclass : 'ToAnchoredWindowHandler',
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'initialization' }
ToLabelEditorWindowHandler >> defaulPositionHook [

	^ [ :event :theLabel |
				theLabel innerElement bounds inSpace bounds topLeft
				- (theLabel editor padding left
					 @ theLabel editor padding top) ]
]

{ #category : 'initialization' }
ToLabelEditorWindowHandler >> initialize [

	super initialize.
	self builder: [ :anchWin :label |
		| ed |
		ed := label newEditor.
		anchWin root addChild: ed.
		ed text: label text copy ]
]

{ #category : 'accessing' }
ToLabelEditorWindowHandler >> windowClass [

	^ ToLabelEditorWindow 
]
