Extension { #name : #BlElement }

{ #category : #'*Toplo-Widget-Pane-Skin' }
BlElement >> spaceRootSkin [

	^ ToWidgetSkin new
		  addLookUpdater:
			  ((self styleSheet newLookUpdaterForPropertyName: #background)
				   when: ToInstallLookEvent value: self toTheme backgroundColor;
				   yourself);
		  yourself
]
