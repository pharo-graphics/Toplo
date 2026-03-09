Class {
	#name : #ToTextResizeBottomRightIcon,
	#superclass : #ToStandardIconicButton,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToTextResizeBottomRightIcon >> initialize [ 

	super initialize.
	self id: #'text-resize-bottom-right-icon'
]

{ #category : #skin }
ToTextResizeBottomRightIcon >> newRawSkin [

	^ ToScriptableSkin new
		  onInstallSkinEvent: [ :e :evt |
			  e innerImage: ToMiscellaneousIcons filled_resize_bottom_right ];
		  yourself
]
