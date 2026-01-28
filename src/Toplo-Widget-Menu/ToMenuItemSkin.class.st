Class {
	#name : #ToMenuItemSkin,
	#superclass : #ToMenuItemElementSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text-disabled') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			(self isTogglable and: [ e isChecked ]) ifFalse: [
					e iconDo: [ :ic |
						ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].
					e endElementDo: [ :ic |
							(ic respondsTo: #adaptToColor:) ifTrue: [
								ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
					e labelDo: [ :lab |
						lab foreground: (e valueOfTokenNamed: #'color-text') ] ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			(self isTogglable and: [e isChecked ]) ifFalse: [
					e iconDo: [ :ic |
						ic adaptToColor: (e valueOfTokenNamed: #'color-primary') ].
					e endElementDo: [ :ic |
							(ic respondsTo: #adaptToColor:) ifTrue: [
								ic adaptToColor: (e valueOfTokenNamed: #'color-primary') ] ].
					e labelDo: [ :lab |
						lab foreground: (e valueOfTokenNamed: #'color-primary') ] ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			(e hasStamp: #iconic) ifFalse: [
					e padding: (BlInsets
							 horizontal: (e valueOfTokenNamed: #'menu-item-padding-H')
							 vertical: (e valueOfTokenNamed: #'menu-item-padding-V')) ].
			e iconDo: [ :ic |
				ic extent: (e valueOfTokenNamed: #'menu-icon-size') ].

			(e isTopMenu not or: [ e showExpandIcon ]) ifTrue: [
					| anyHaveIcon anyIsMenu flow horizontalParent |
					anyHaveIcon := false.
					anyIsMenu := false.
					flow := false.
					horizontalParent := true.
					e parentMenuOrMenuPaneDo: [ :pm |
							horizontalParent := true.
							pm menuWindowDo: [ :mw |
								horizontalParent := mw itemList isHorizontal ].
							flow := pm isFlowable.
							horizontalParent ifFalse: [
									pm items do: [ :item |
											item hasIcon ifTrue: [ anyHaveIcon := true ].
											item isMenu ifTrue: [ anyIsMenu := true ] ] ] ].

					anyHaveIcon ifTrue: [
							| align |
							align := e valueOfTokenNamed: #'menu-item-start-alignment'.
							e startAlignment: align ].

					(flow not and: [ anyIsMenu or: [ e showExpandIcon ] ]) ifTrue: [
							e isHorizontal
								ifTrue: [
										e endInterspace: (e valueOfTokenNamed: #'button-interspace').
										e endFlexible: true ]
								ifFalse: [
										e endInterspace: 0.
										e endFlexible: false ] ] ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			(self isTogglable and: [e isChecked ]) ifFalse: [
					e iconDo: [ :ic |
						ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].
					e endElementDo: [ :ic |
							(ic respondsTo: #adaptToColor:) ifTrue: [
								ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
					e labelDo: [ :lab |
						lab foreground: (e valueOfTokenNamed: #'color-text') ] ] ]
]

{ #category : #'event handling' }
ToMenuItemSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		self isTogglable ifFalse: [
					e iconDo: [ :ic |
						ic adaptToColor:
							(e valueOfTokenNamed: #'color-primary-pressed') ].
					e endElementDo: [ :ic |
							(ic respondsTo: #adaptToColor:) ifTrue: [
								ic adaptToColor:
									(e valueOfTokenNamed: #'color-primary-pressed') ] ] ] ]
]
