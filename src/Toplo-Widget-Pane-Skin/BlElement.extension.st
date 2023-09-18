Extension { #name : #BlElement }

{ #category : #'*Toplo-Widget-Pane-Skin' }
BlElement >> spaceRootSkin [

	^ ToSkin new writers: { ToPropertyWriter new eventClass: ToInstallLookEvent; property: (ToFeatureProperty new name: #background); value: [ :e | e toTheme backgroundColor ] }
]
